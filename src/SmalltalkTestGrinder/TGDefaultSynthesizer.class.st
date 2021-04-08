Class {
	#name : #TGDefaultSynthesizer,
	#superclass : #TGAbstractMethodSynthesizer,
	#instVars : [
		'varNameMapper'
	],
	#category : #'SmalltalkTestGrinder-4.Synthesis'
}

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> defaultVariableNameFor: aUniqId [
	^ 'var_', aUniqId asString
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> genAssgnmentNode: aNode toVariableNode: lhsVariableNode [
	^ RBAssignmentNode
		variable: lhsVariableNode
		value: aNode
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> genCallNew: aClassName [
	^ RBMessageNode
		receiver: (RBVariableNode named: aClassName)
		selector: 'new'
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> genLiteral: theValue [
	^ RBLiteralValueNode value: theValue
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> genLiteralFromString: theValue [
	^ RBParser parseExpression: (theValue asString)
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> genVariableFor: anObject [
	^ RBVariableNode named: (self variableNameMapping: anObject uniqueId)
]

{ #category : #initialization }
TGDefaultSynthesizer >> initialize [
	varNameMapper := Dictionary new
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisBlockValue: anObject [
	^ anObject theASTNode
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisClassPrimitiveValue: anObject [
	^ RBVariableNode named: anObject theValue name
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisDictionaryValue: anObject [
	anObject theValues isEmpty 
		ifTrue: [ ^ self synthesisDictionaryValueEmpty: anObject ].
	anObject areAllPrimitive 
		ifTrue: [ ^ self synthesisDictionaryValueCascade: anObject  ] 
		ifFalse: [ ^ self synthesisDictionaryValueCascadeDependency: anObject  ] 
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisDictionaryValueCascade: anObject [
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
TGDefaultSynthesizer >> synthesisDictionaryValueCascadeDependency: anObject [
	| receiver msgs |
	self flag: #TODO
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisDictionaryValueEmpty: anObject [
	^ self genCallNew: #Dictionary
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisFractionValue: anObject [
	^ self genLiteralFromString: anObject theValue
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisListValue: anObject [
	anObject theValues ifEmpty: [ ^ self synthesisListValueEmpty: anObject ].
	anObject areAllPrimitive 
		ifTrue: [ ^ self synthesisListValuePrimitive: anObject ]
		ifFalse: [ ^ self synthesisListValuePrimitiveDependencies: anObject ]
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisListValueEmpty: anObject [
	^ self genCallNew: anObject theClass name
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisListValuePrimitive: anObject [
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
TGDefaultSynthesizer >> synthesisListValuePrimitiveDependencies: anObject [
	self flag: #todo
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisNullValue: anObject [
	^ RBLiteralValueNode value: nil
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisObjectEvent: anObjectEvent [
	| args |
	args := anObjectEvent argsBefore collect: [ :arg | arg synthesisBy: self ].
	^ RBMessageNode
			receiver: (self genVariableFor: anObjectEvent parent objectReference)				
			selector: anObjectEvent selector
			arguments: args
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisObjectHistory: anObjectHistory [
	| statements |
	statements := OrderedCollection new.
	statements add: (self genAssgnmentNode: (self genCallNew: anObjectHistory objectReference theClass name) 
			toVariableNode: (self genVariableFor: anObjectHistory objectReference)).
	statements addAll: (anObjectHistory selectedEvents collect: [:ev | ev synthesisBy: self]).
	^ statements 
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisObjectReference: anObject [
	^ RBVariableNode named: (self variableNameMapping: anObject uniqueId)
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisPrimitiveValue: anObject [
	^ self genLiteral: anObject theValue
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisSkippedValue: anObject [
	^ self genCallNew: anObject theClass name
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> synthesisTestMethod: aTestMethod [
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
TGDefaultSynthesizer >> varNameMapper [
	^ varNameMapper
]

{ #category : #accessing }
TGDefaultSynthesizer >> varNameMapper: anObject [
	varNameMapper := anObject
]

{ #category : #'as yet unclassified' }
TGDefaultSynthesizer >> variableNameMapping: aUniqId [
	^ varNameMapper at: aUniqId ifAbsent: [ self defaultVariableNameFor: aUniqId ] 
]
