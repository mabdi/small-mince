Class {
	#name : #SMReturnLogRecord,
	#superclass : #SMAbstractLogRecord,
	#instVars : [
		'returnValue'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMReturnLogRecord >> for: aReceiver selector: aSelector args: anArgs result: aValue [
	receiver := aReceiver sm_valueReference.
	selector := aSelector.
	state := self captureState: aReceiver.
	locals := self captureLocals.
	arguments := self captureArgsState: anArgs.
	self returnValue: aValue sm_valueReference.
]

{ #category : #testing }
SMReturnLogRecord >> isReturn [
	^ true
]

{ #category : #accessing }
SMReturnLogRecord >> returnValue [
	^ returnValue
]

{ #category : #accessing }
SMReturnLogRecord >> returnValue: anObject [
	returnValue := anObject
]
