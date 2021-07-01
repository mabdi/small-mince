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
	self receiver: aReceiver sm_valueReference.
	self selector: aSelector.
	self state: (self captureState: aReceiver).
	self locals: self captureLocals.
	self arguments: (self captureArgsState: anArgs).
	self returnValue: aValue sm_valueReference
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
