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
