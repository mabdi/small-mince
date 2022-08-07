Class {
	#name : #SMDependencyBasedTestTransplantation,
	#superclass : #SMAbstractStrategy,
	#instVars : [
		'minimize',
		'toMock'
	],
	#category : #'SmallMince-Core-2.Strategies'
}

{ #category : #testing }
SMDependencyBasedTestTransplantation >> canWePickNode: node V: theV [

	| event myLinks |
	event := self getIncomingEventEdge: node.
	event ifNil: [ ^ true ].
	(event arguments select: #isObjectReference) do: [ :arg | 
		theV do: [ :v | v ~ arg ifTrue: [ arg > v ifTrue: [ ^ false ] ] ] ].
	myLinks := links at: node ifAbsent: [^ true].
	myLinks usedAsArg do: [ :arg | 
		theV do: [ :v | v ~ arg ifTrue: [ arg > v ifTrue: [ ^ false ] ] ] ].
	myLinks returns do: [ :arg | 
		theV do: [ :v | v ~ arg ifTrue: [ arg > v ifTrue: [ ^ false ] ] ] ].
	myLinks argReturns do: [ :arg | 
		theV do: [ :v | v ~ arg ifTrue: [ arg > v ifTrue: [ ^ false ] ] ] ].

	^ true
]

{ #category : #running }
SMDependencyBasedTestTransplantation >> convertToTestMethodModel: subgraphs [

	| models |
	models := subgraphs collect: [ :s | 
		          s withIndexCollect: [ :item :index | 
			          (SMTestMethod from: item) methodName:
				          ('test' , index asString) asSymbol ] ].
	^ models
]

{ #category : #'as yet unclassified' }
SMDependencyBasedTestTransplantation >> extractSubGraphs: aSeedRecord [

	| theV theS subgraphs |
	theV := Set with: aSeedRecord receiver getNextVersion.
	theS := OrderedCollection new.
	subgraphs := self traverseGraphV: theV S: theS.
	^ subgraphs
]

{ #category : #'as yet unclassified' }
SMDependencyBasedTestTransplantation >> filterTraces [
	^ slicingCriteria value: traces. 
	
]

{ #category : #'as yet unclassified' }
SMDependencyBasedTestTransplantation >> getIncomingEventEdge: node [

	| history |
	history := traces at: node asIndex ifAbsent: [ ^ nil ].
	node version -1 = 0 ifTrue: [ ^ nil ].
	^ history at: node version -1
]

{ #category : #initialization }
SMDependencyBasedTestTransplantation >> initialize [

	minimize := false.
	toMock := {  }
]

{ #category : #removing }
SMDependencyBasedTestTransplantation >> removeDuplicatesIn: subgraphs [

	self flag: #todo. "here you can remove all reduced traces that are duplicated"
	^ subgraphs 
]

{ #category : #running }
SMDependencyBasedTestTransplantation >> run [

	| seeds subgraphs |
	seeds := self filterTraces.
	subgraphs := seeds collect: [ :seed | self extractSubGraphs: seed ].
	subgraphs := self removeDuplicatesIn: subgraphs.
	^ self convertToTestMethodModel: subgraphs.

]

{ #category : #initialization }
SMDependencyBasedTestTransplantation >> setMinimize: value [ 
	minimize := value
]

{ #category : #accessing }
SMDependencyBasedTestTransplantation >> toMock [

	^ toMock
]

{ #category : #accessing }
SMDependencyBasedTestTransplantation >> toMock: anObject [
	anObject ifNil: [ ^ self ].
	toMock := anObject
]

{ #category : #'as yet unclassified' }
SMDependencyBasedTestTransplantation >> traverseGraphV: theV S: theS [

	| edge targetNode index targetVersion thisNode |
	self flag: #todo. "Too messy."
	results := OrderedCollection new.

	[ theV isEmpty ] whileFalse: [ 
		targetNode := theV asOrderedCollection detect: [ :node | 
			              self canWePickNode: node V: theV ].
		self flag: #todo. "I dont consider return and argRet in POC. use recursive call for implemeting them. It will make plenty of cases (exponential computation)"
		theV remove: targetNode.
		targetNode isObjectToMock
			ifTrue: [ 
				thisNode := targetNode.
				index := targetNode mockEvent argsAfter indexOf: targetNode.
				targetVersion := (targetNode mockEvent arguments at: 2) version.
				[ thisNode version > targetVersion ] whileTrue: [ 
					edge := self getIncomingEventEdge: thisNode.
					theS add: { 
							#mock.
							edge }.
					thisNode := edge receiver.
					self flag: #todo "You may go deeper in the graph in advanced use cases" ].
				theS add: { 
						#mockNew.
						targetNode } ]
			ifFalse: [ 
				edge := self getIncomingEventEdge: targetNode.
				edge
					ifNil: [ 
						targetNode version = 1 ifTrue: [ 
							theS add: { 
									#new.
									targetNode } ] ]
					ifNotNil: [ 
						[ minimize & edge isStatePreserving ] whileTrue: [ 
							edge := self getIncomingEventEdge: edge receiver ].

						theV addAll: ((edge argsAfter select: [ :arg | 
								  arg isObjectReference and: [ toMock includes: arg theClass ] ]) 
								 collect: [ :arg | arg asMockObject: edge ]).
						(edge arguments select: [ :arg | 
							 arg isObjectReference and: [ toMock includes: arg theClass ] ]) 
							do: [ :arg | arg asMockObject: edge ].
						theV addAll: ((edge arguments select: [ :arg | 
								  arg isObjectReference and: [ 
									  (toMock includes: arg theClass) not ] ]) collect: [ :arg | 
								 theV add: arg ]).
						theV add: edge receiver.
						theS add: { 
								#event.
								edge } ] ] ].
	results add: theS.
	^ results
]
