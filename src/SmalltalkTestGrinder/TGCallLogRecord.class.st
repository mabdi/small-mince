Class {
	#name : #TGCallLogRecord,
	#superclass : #TGAbstractLogRecord,
	#category : #'SmalltalkTestGrinder-Model'
}

{ #category : #'as yet unclassified' }
TGCallLogRecord >> for: aReceiver selector: aSelector args: anArgs [
	receiver := aReceiver tg_valueReference.
	selector := aSelector.
	state := self captureState: aReceiver.
	locals := self captureLocals.
	arguments := self captureArgsState: anArgs.
	self flag: #TODO. "add argNodes and usefull info from stack"
]

{ #category : #testing }
TGCallLogRecord >> isCall [
	^ true
]
