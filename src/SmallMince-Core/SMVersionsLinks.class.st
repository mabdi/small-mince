Class {
	#name : #SMVersionsLinks,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#instVars : [
		'returns',
		'argReturns',
		'usedAsArg'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #adding }
SMVersionsLinks >> addArgReturn: aRef [

	argReturns add: aRef
]

{ #category : #adding }
SMVersionsLinks >> addReturn: aRef [
	returns add: aRef.
]

{ #category : #adding }
SMVersionsLinks >> addUsedAsArg: aRef [

	usedAsArg  add: aRef
]

{ #category : #accessing }
SMVersionsLinks >> argReturns [

	^ argReturns
]

{ #category : #'reflective operations' }
SMVersionsLinks >> gtDisplayString [

	^ usedAsArg size asString, ':', returns size asString , ':' , argReturns size asString
]

{ #category : #initialization }
SMVersionsLinks >> initialize [

	argReturns := Set new.
	returns := Set new.
	usedAsArg := Set new.
]

{ #category : #printing }
SMVersionsLinks >> printOn: aStream [

	aStream nextPutAll: self gtDisplayString
]

{ #category : #accessing }
SMVersionsLinks >> returns [

	^ returns
]

{ #category : #accessing }
SMVersionsLinks >> usedAsArg [

	^ usedAsArg
]
