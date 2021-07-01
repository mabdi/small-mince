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
	self receiver: aReceiver sm_valueReference.
	self selector: aSelector.
	self state: (self captureState: aReceiver).
	self locals: self captureLocals.
	self arguments: (self captureArgsState: anArgs).
	self exception: anException sm_valueReference
]

{ #category : #testing }
SMExceptionLogRecord >> isException [
	^ true
]
