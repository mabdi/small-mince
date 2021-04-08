Class {
	#name : #TGReturnLogRecord,
	#superclass : #TGAbstractLogRecord,
	#instVars : [
		'returnValue'
	],
	#category : #'SmalltalkTestGrinder-Core-Model'
}

{ #category : #'as yet unclassified' }
TGReturnLogRecord >> for: aReceiver selector: aSelector args: anArgs result: aValue [
	receiver := aReceiver tg_valueReference.
	selector := aSelector.
	state := self captureState: aReceiver.
	locals := self captureLocals.
	arguments := self captureArgsState: anArgs.
	returnValue := aValue tg_valueReference.
]

{ #category : #testing }
TGReturnLogRecord >> isReturn [
	^ true
]

{ #category : #accessing }
TGReturnLogRecord >> returnValue [
	^ returnValue
]

{ #category : #accessing }
TGReturnLogRecord >> returnValue: anObject [
	returnValue := anObject
]
