Class {
	#name : #SMObjectValue,
	#superclass : #SMAbstractValue,
	#instVars : [
		'version',
		'stack',
		'pre_record'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'instance creation' }
SMObjectValue class >> with: anObject [

	| obj |
	obj := super with: anObject.
	^ obj
]

{ #category : #comparing }
SMObjectValue >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	version = anObject version ifFalse: [ ^ false ].
	^ true
]

{ #category : #versions }
SMObjectValue >> initialize [ 
	super initialize.
	version := 0
]

{ #category : #testing }
SMObjectValue >> isObjectValue [
	^ true
]

{ #category : #accessing }
SMObjectValue >> pre_record [

	^ pre_record
]

{ #category : #accessing }
SMObjectValue >> pre_record: anObject [

	pre_record := anObject
]

{ #category : #accessing }
SMObjectValue >> stack [
	stack ifNil: [ stack := Stack new ].
	^ stack
]

{ #category : #'as yet unclassified' }
SMObjectValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisObjectReference: self
]

{ #category : #accessing }
SMObjectValue >> version [

	^ version
]

{ #category : #versions }
SMObjectValue >> versionIncrease [
	version := version +1
]
