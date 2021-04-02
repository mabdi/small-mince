Class {
	#name : #TGReturnLogRecord,
	#superclass : #TGAbstractLogRecord,
	#instVars : [
		'returnValue',
		'returnNode',
		'coveredNodes'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #accessing }
TGReturnLogRecord >> coveredNodes [
	^ coveredNodes
]

{ #category : #accessing }
TGReturnLogRecord >> coveredNodes: anObject [
	coveredNodes := anObject
]

{ #category : #'as yet unclassified' }
TGReturnLogRecord >> for: aReceiver selector: aSelector args: anArgs result: aValue [
	receiver := aReceiver tg_valueReference.
	selector := aSelector.
	state := self captureState: aReceiver.
	locals := self captureLocals: thisContext.
	arguments := self captureArgsState: anArgs.
	returnValue := aValue tg_valueReference.
	self flag: #TODO. "add return Node and covered Nodes"
]

{ #category : #accessing }
TGReturnLogRecord >> returnNode [
	^ returnNode
]

{ #category : #accessing }
TGReturnLogRecord >> returnNode: anObject [
	returnNode := anObject
]

{ #category : #accessing }
TGReturnLogRecord >> returnValue [
	^ returnValue
]

{ #category : #accessing }
TGReturnLogRecord >> returnValue: anObject [
	returnValue := anObject
]
