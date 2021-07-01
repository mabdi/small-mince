Class {
	#name : #SMExceptionLogRecord,
	#superclass : #SMAbstractLogRecord,
	#instVars : [
		'exception'
	],
	#category : #'SmallMince-Core-Model'
}

{ #category : #accessing }
SMExceptionLogRecord >> exception [
	^ exception
]

{ #category : #accessing }
SMExceptionLogRecord >> exception: anObject [
	exception := anObject
]

{ #category : #'as yet unclassified' }
SMExceptionLogRecord >> for: aReceiver selector: aSelector args: anArgs exception: anException [
	receiver := aReceiver sm_valueReference.
	selector := aSelector.
	state := self captureState: aReceiver.
	locals := self captureLocals.
	arguments := self captureArgsState: anArgs.
	self exception: anException sm_valueReference
]

{ #category : #testing }
SMExceptionLogRecord >> isException [
	^ true
]
