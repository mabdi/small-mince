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

{ #category : #accessing }
TGCallLogRecord >> stackTrace [
	^ stackTrace
]

{ #category : #accessing }
TGCallLogRecord >> stackTrace: anObject [
	stackTrace := anObject
]
