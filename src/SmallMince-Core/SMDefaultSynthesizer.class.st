Class {
	#name : #SMDefaultSynthesizer,
	#superclass : #SMAbstractMethodSynthesizer,
	#instVars : [
		'varNameMapper',
		'tmps',
		'methodModel'
	],
	#category : #'SmallMince-Core-4.Synthesis'
}

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> defaultVariableNameFor: aUniqId [
	^ 'var_', aUniqId asString
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> genAssgnmentNode: aNode toVariableNode: lhsVariableNode [
	^ RBAssignmentNode
		variable: lhsVariableNode
		value: aNode
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> genCallNew: aClassName [
	^ RBMessageNode
		receiver: (RBVariableNode named: aClassName)
		selector: 'new'
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> genLiteral: theValue [
	^ RBLiteralValueNode value: theValue
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> genLiteralFromString: theValue [
	^ RBParser parseExpression: (theValue asString)
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> genVariableFor: anObject [
	^ RBVariableNode named: (self variableNameMapping: anObject uniqueId)
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> getATempVariable [
	tmps := tmps + 1.
	^ RBVariableNode named: ('tmp_', tmps asString )
]

{ #category : #initialization }
SMDefaultSynthesizer >> initialize [
	varNameMapper := Dictionary new.
	tmps := 0
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisBlockValue: anObject [
	^ anObject theASTNode
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisClassPrimitiveValue: anObject [
	^ (RBVariableNode named: anObject theValue name)
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisDependency: anObjectReference [
	| objectModel |
	methodModel ifNil: [ ^ {  } ].
	objectModel := methodModel dependencies
		detect: [ :dep | dep objectReference uniqueId = anObjectReference uniqueId ].
	objectModel toEvent: anObjectReference lastRecordId.
	^ objectModel synthesisBy: self
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisDictionaryValue: anObject [
	anObject theValues isEmpty
		ifTrue: [ ^ self synthesisDictionaryValueEmpty: anObject ].
	^ self synthesisDictionaryValueNonEmpty: anObject.
	
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisDictionaryValueCascade: anObject [
	| receiver msgs |
	self flag: #todo. "dont use cascade"
	receiver := self genCallNew: #Dictionary.
	msgs := OrderedCollection new.
	anObject theValues
		keysAndValuesDo: [ :k :v | 
			msgs
				add:
					(RBMessageNode
						receiver: receiver copy
						selector: #at:put:
						arguments:
							{(RBLiteralValueNode value: k).
							(v synthesisBy: self)}) ].
	msgs
		add:
			(RBMessageNode
				receiver: receiver copy
				selector: #yourself
				arguments: {}).
	^ {(RBCascadeNode messages: msgs)}
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisDictionaryValueEmpty: anObject [
	^ {self genCallNew: #Dictionary}
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisDictionaryValueNonEmpty: anObject [
	| receiver statements |
	statements := OrderedCollection new.
	receiver := self getATempVariable.
	statements
		add:
			(self
				genAssgnmentNode: (self genCallNew: #Dictionary)
				toVariableNode: receiver).
	anObject theValues
		keysAndValuesDo: [ :k :v | 
			| node val |
			node := v synthesisBy: self.
			node isSequence
				ifTrue: [ val := node statements last.
					node removeNode: val.
					statements addAll: node statements ]
				ifFalse: [ val := node ].
			statements
				add:
					(RBMessageNode
						receiver: receiver copy
						selector: #at:put:
						arguments:
							{(RBLiteralValueNode value: k).
							(val)}) ].
	statements add: receiver.	"It's a contract between methods in this synthesizer: if the type is a sequence, the last statement refers the variable"
	^ RBSequenceNode statements: statements
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisFractionValue: anObject [
	^ (self genLiteralFromString: anObject theValue)
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisListValue: anObject [
	anObject theValues
		ifEmpty: [ ^ self synthesisListValueEmpty: anObject ].
	^ self synthesisListValueNonEmpty: anObject
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisListValueEmpty: anObject [
	^ (self genCallNew: anObject theClass name)
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisListValueNonEmpty: anObject [
	| receiver statements |
	statements := OrderedCollection new.
	receiver := self getATempVariable.
	statements
		add:
			(self
				genAssgnmentNode: (self genCallNew: anObject theClass name)
				toVariableNode: receiver).
	anObject theValues asOrderedCollection
		do: [ :v | 
			| node val |
			node := v synthesisBy: self.
			node isSequence
				ifTrue: [ val := node statements last.
					node removeNode: val.
					statements addAll: node statements ]
				ifFalse: [ val := node ].
			statements
				add:
					(RBMessageNode
						receiver: receiver copy
						selector: #add:
						arguments: {val}) ].
	statements add: receiver.	"It's a contract between methods in this synthesizer: if the type is a sequence, the last statement refers the variable"
	^ RBSequenceNode statements: statements
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisNullValue: anObject [
	^ (RBLiteralValueNode value: nil)
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisObjectErrorEvent: anObjectEvent [
	| call statements |
	statements := self synthesisObjectReturnEvent: anObjectEvent.
	call := statements statements last.
	call := RBMessageNode
		receiver: (RBBlockNode body: (RBSequenceNode statements: {call}))
		selector: #on:do:
		arguments:
			{(RBGlobalNode named: anObjectEvent exceptionValue theClass name).
			(RBBlockNode
				arguments: {(RBArgumentNode named: #sm_error)}
				body: (RBSequenceNode statements: {}))}.
	statements statements at: statements statements size put: call.
	^ statements
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisObjectHistory: anObjectHistory [
	| statements |
	statements := OrderedCollection new.
	anObjectHistory fromEvent ifNil: [statements
		add:
			(self
				genAssgnmentNode: (self genCallNew: anObjectHistory objectReference theClass name)
				toVariableNode: (self genVariableFor: anObjectHistory objectReference))].
	statements
		addAll:
			(anObjectHistory selectedEvents
				flatCollect: [ :ev | (ev synthesisBy: self) statements ]).
	^ statements
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisObjectReference: anObject [
	^ (RBVariableNode
		named: (self variableNameMapping: anObject uniqueId))
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisObjectReturnEvent: anObjectEvent [
	| args statements |
	statements := OrderedCollection new.
	args := anObjectEvent argsBefore
		collect: [ :arg | 
			| node |
			arg isObjectValue ifTrue: [ statements addAll: (self synthesisDependency: arg) ].
			node := arg synthesisBy: self.
			node isSequence
				ifTrue: [ statements addAll: node statements allButLast ]
				ifFalse: [ node ] ].
	statements
		add:
			(RBMessageNode
				receiver: (self genVariableFor: anObjectEvent parent objectReference)
				selector: anObjectEvent selector
				arguments: args).
	^ RBSequenceNode statements: statements
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisPrimitiveValue: anObject [
	^ (self genLiteral: anObject theValue)
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisSkippedValue: anObject [
	^ (self genCallNew: anObject theClass name)
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisTestMethod: aTestMethod [
	| theMethod theSequence statements temporaries |
	statements := OrderedCollection new.
	methodModel := aTestMethod.
	statements addAll: (aTestMethod objectUnderTest synthesisBy: self).
	temporaries := statements
		select: #isAssignment
		thenCollect: [ :anAssignment | RBTemporaryNode named: anAssignment variable name ].
	theSequence := RBSequenceNode
		temporaries: temporaries
		statements: statements.
	theMethod := RBMethodNode
		selector: aTestMethod methodName
		body: theSequence.
	^ theMethod
]

{ #category : #accessing }
SMDefaultSynthesizer >> varNameMapper [
	^ varNameMapper
]

{ #category : #accessing }
SMDefaultSynthesizer >> varNameMapper: anObject [
	varNameMapper := anObject
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> variableNameMapping: aUniqId [
	^ varNameMapper at: aUniqId ifAbsent: [ self defaultVariableNameFor: aUniqId ] 
]
