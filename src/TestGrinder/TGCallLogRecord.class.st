Class {
	#name : #TGCallLogRecord,
	#superclass : #TGAbstractLogRecord,
	#instVars : [
		'stackTrace',
		'argNodes'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #accessing }
TGCallLogRecord >> argNodes [
	^ argNodes
]

{ #category : #accessing }
TGCallLogRecord >> argNodes: anObject [
	argNodes := anObject
]

{ #category : #'as yet unclassified' }
TGCallLogRecord >> for: aReceiver selector: aSelector args: anArgs [
	receiver := aReceiver tg_valueReference.
	selector := aSelector.
	state := self captureState: aReceiver.
	locals := self captureLocals: thisContext.
	arguments := self captureArgsState: anArgs.
	self flag: #TODO. "add argNodes and usefull info from stack"
]

{ #category : #testing }
TGCallLogRecord >> isCall [
	^ true
]

{ #category : #accessing }
TGCallLogRecord >> stackTrace [
	^ stackTrace
]

{ #category : #accessing }
TGCallLogRecord >> stackTrace: anObject [
	stackTrace := anObject
]
