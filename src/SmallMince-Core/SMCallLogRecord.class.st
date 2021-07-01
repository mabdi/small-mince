Class {
	#name : #SMCallLogRecord,
	#superclass : #SMAbstractLogRecord,
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMCallLogRecord >> for: aReceiver selector: aSelector args: anArgs [
	self receiver: aReceiver sm_valueReference.
	self selector: aSelector.
	self state: (self captureState: aReceiver).
	self locals: self captureLocals.
	self arguments: (self captureArgsState: anArgs).
	self flag: #TODO	"add argNodes and usefull info from stack"
]

{ #category : #testing }
SMCallLogRecord >> isCall [
	^ true
]
