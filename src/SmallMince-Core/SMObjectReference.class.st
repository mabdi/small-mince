Class {
	#name : #SMObjectReference,
	#superclass : #SMAbstractValue,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'version',
		'visited',
		'beMocked',
		'mockEvent'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'instance creation' }
SMObjectReference class >> from: anObject [

^ self new uniqueId: anObject uniqueId ; version: anObject version ; theClass: anObject theClass; yourself
]

{ #category : #'as yet unclassified' }
SMObjectReference >> < anObject [

	anObject ~ self ifFalse: [ ^ false ].
	self version < anObject version ifFalse: [ ^ false ].
	^ true
]

{ #category : #'as yet unclassified' }
SMObjectReference >> > anObject [

	anObject ~ self  ifFalse: [ ^ false ].
	self version > anObject version ifFalse: [ ^ false ].
	^ true
]

{ #category : #converting }
SMObjectReference >> asIndex [

	^ SMObjectIndex
		         forClass: theClass
		         anId: uniqueId
]

{ #category : #converting }
SMObjectReference >> asMockObject: event [

	beMocked := true.
	mockEvent := event
]

{ #category : #copying }
SMObjectReference >> clone [

	^ self class new
		  uniqueId: self uniqueId;
		  version: self version;
		  theClass: self theClass; yourself
]

{ #category : #copying }
SMObjectReference >> getNextVersion [

	^ self class new
		  uniqueId: self uniqueId;
		  version: self version + 1;
		  theClass: self theClass;
		  yourself
]

{ #category : #'reflective operations' }
SMObjectReference >> gtDisplayString [

	^ theClass name , ':V' , version asString, ':',  uniqueId asString
]

{ #category : #testing }
SMObjectReference >> isObjectReference [

	^ true
]

{ #category : #testing }
SMObjectReference >> isObjectToMock [

	beMocked ifNil: [ beMocked:= false ].
	^ beMocked
]

{ #category : #accessing }
SMObjectReference >> isVisited [

	^ visited
]

{ #category : #accessing }
SMObjectReference >> mockEvent [

	^ mockEvent
]

{ #category : #printing }
SMObjectReference >> printOn: aStream [

	aStream nextPutAll: self gtDisplayString
]

{ #category : #'as yet unclassified' }
SMObjectReference >> synthesisBy: aSynthesizer [
	^ aSynthesizer genVariableFor: self
]

{ #category : #accessing }
SMObjectReference >> version [

	^ version
]

{ #category : #accessing }
SMObjectReference >> version: anObject [

	version := anObject
]

{ #category : #accessing }
SMObjectReference >> visited: anObject [

	visited := anObject
]

{ #category : #'as yet unclassified' }
SMObjectReference >> ~ anObject [
	anObject class = self class ifFalse: [ ^ false ].
	anObject theClass = self theClass ifFalse: [ ^ false ].
	anObject uniqueId = self uniqueId ifFalse: [ ^ false ].
	^ true
]
