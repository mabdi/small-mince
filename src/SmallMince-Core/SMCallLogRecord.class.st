Class {
	#name : #SMCallLogRecord,
	#superclass : #SMAbstractLogRecord,
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMCallLogRecord >> for: aReceiver selector: aSelector args: anArgs [
	receiver := aReceiver sm_valueReference.
	selector := aSelector.
	state := self captureState: aReceiver.
	locals := self captureLocals.
	arguments := self captureArgsState: anArgs.
	self flag: #TODO. "add argNodes and usefull info from stack"
]

{ #category : #testing }
SMCallLogRecord >> isCall [
	^ true
]
