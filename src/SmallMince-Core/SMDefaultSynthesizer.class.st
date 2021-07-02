Class {
	#name : #SMDefaultSynthesizer,
	#superclass : #SMAbstractMethodSynthesizer,
	#instVars : [
		'varNameMapper'
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

{ #category : #initialization }
SMDefaultSynthesizer >> initialize [
	varNameMapper := Dictionary new
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisBlockValue: anObject [
	^ anObject theASTNode
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisClassPrimitiveValue: anObject [
	^ RBVariableNode named: anObject theValue name
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisDictionaryValue: anObject [
	anObject theValues isEmpty 
		ifTrue: [ ^ self synthesisDictionaryValueEmpty: anObject ].
	anObject areAllPrimitive 
		ifTrue: [ ^ self synthesisDictionaryValueCascade: anObject  ] 
		ifFalse: [ ^ self synthesisDictionaryValueCascadeDependency: anObject  ] 
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisDictionaryValueCascade: anObject [
	| receiver msgs |
	receiver := self genCallNew: #Dictionary.
	msgs := OrderedCollection new.
	anObject theValues keysAndValuesDo: [:k :v | msgs add: (RBMessageNode
			receiver: receiver copy				
			selector: #at:put:
			arguments:
				{(RBLiteralValueNode value: k).
				v synthesisBy: self}) ].
	msgs add: (RBMessageNode
			receiver: receiver copy				
			selector: #yourself
			arguments: {}).		
	^ RBCascadeNode
	messages: msgs. 
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisDictionaryValueCascadeDependency: anObject [
	| receiver msgs |
	self flag: #TODO
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisDictionaryValueEmpty: anObject [
	^ self genCallNew: #Dictionary
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisFractionValue: anObject [
	^ self genLiteralFromString: anObject theValue
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisListValue: anObject [
	anObject theValues ifEmpty: [ ^ self synthesisListValueEmpty: anObject ].
	anObject areAllPrimitive 
		ifTrue: [ ^ self synthesisListValuePrimitive: anObject ]
		ifFalse: [ ^ self synthesisListValuePrimitiveDependencies: anObject ]
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisListValueEmpty: anObject [
	^ self genCallNew: anObject theClass name
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisListValuePrimitive: anObject [
	| receiver msgs |
	receiver := self genCallNew: anObject theClass name.
	msgs := anObject theValues asOrderedCollection collect: [ :v | RBMessageNode
			receiver: receiver copy				
			selector: #add:
			arguments:
				{v synthesisBy: self} ].
	msgs add: (RBMessageNode
			receiver: receiver copy				
			selector: #yourself
			arguments: {}).		
	^ RBCascadeNode
	messages: msgs. 
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisListValuePrimitiveDependencies: anObject [
	self flag: #todo
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisNullValue: anObject [
	^ RBLiteralValueNode value: nil
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisObjectErrorEvent: anObjectEvent [
	| args |
	args := anObjectEvent argsBefore
		collect: [ :arg | arg synthesisBy: self ].
	^ RBMessageNode
		receiver:
			(RBBlockNode
				body:
					(RBSequenceNode
						statements:
							{(RBMessageNode
								receiver: (self genVariableFor: anObjectEvent parent objectReference)
								selector: anObjectEvent selector
								arguments: args)}))
		selector: #on:do:
		arguments:
			{(RBGlobalNode named: anObjectEvent exceptionValue theClass name ).
			(RBBlockNode
				arguments: {(RBArgumentNode named: #sm_error)}
				body: (RBSequenceNode statements: {}))}
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisObjectHistory: anObjectHistory [
	| statements |
	statements := OrderedCollection new.
	statements add: (self genAssgnmentNode: (self genCallNew: anObjectHistory objectReference theClass name) 
			toVariableNode: (self genVariableFor: anObjectHistory objectReference)).
	statements addAll: (anObjectHistory selectedEvents collect: [:ev | ev synthesisBy: self]).
	^ statements 
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisObjectReference: anObject [
	^ RBVariableNode named: (self variableNameMapping: anObject uniqueId)
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisObjectReturnEvent: anObjectEvent [
	| args |
	args := anObjectEvent argsBefore
		collect: [ :arg | arg synthesisBy: self ].
	^ RBMessageNode
		receiver: (self genVariableFor: anObjectEvent parent objectReference)
		selector: anObjectEvent selector
		arguments: args
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisPrimitiveValue: anObject [
	^ self genLiteral: anObject theValue
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisSkippedValue: anObject [
	^ self genCallNew: anObject theClass name
]

{ #category : #'as yet unclassified' }
SMDefaultSynthesizer >> synthesisTestMethod: aTestMethod [
	| theMethod theSequence statements temporaries |
	statements := OrderedCollection new.
	statements addAll: (aTestMethod objectUnderTest synthesisBy: self).
	temporaries := statements
		select: #isAssignment
		thenCollect: [ :anAssignment | RBTemporaryNode named: anAssignment variable name ].
	theSequence := RBSequenceNode temporaries: temporaries statements: statements.
	theMethod := RBMethodNode selector: aTestMethod methodName body: theSequence.
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
