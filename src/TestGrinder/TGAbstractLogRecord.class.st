Class {
	#name : #TGAbstractLogRecord,
	#superclass : #Object,
	#instVars : [
		'id',
		'receiver',
		'selector',
		'state',
		'locals',
		'arguments'
	],
	#category : #'TestGrinder-Model'
}

{ #category : #accessing }
TGAbstractLogRecord >> arguments [
	^ arguments
]

{ #category : #accessing }
TGAbstractLogRecord >> arguments: anObject [
	arguments := anObject
]

{ #category : #'as yet unclassified' }
TGAbstractLogRecord >> for: aReceiver selector: aSelector args: anArgs [
	
]

{ #category : #accessing }
TGAbstractLogRecord >> id [
	^ id
]

{ #category : #accessing }
TGAbstractLogRecord >> id: anObject [
	id := anObject
]

{ #category : #accessing }
TGAbstractLogRecord >> locals [
	^ locals
]

{ #category : #accessing }
TGAbstractLogRecord >> locals: anObject [
	locals := anObject
]

{ #category : #accessing }
TGAbstractLogRecord >> receiver [
	^ receiver
]

{ #category : #accessing }
TGAbstractLogRecord >> receiver: anObject [
	receiver := anObject
]

{ #category : #accessing }
TGAbstractLogRecord >> selector [
	^ selector
]

{ #category : #accessing }
TGAbstractLogRecord >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
TGAbstractLogRecord >> state [
	^ state
]

{ #category : #accessing }
TGAbstractLogRecord >> state: anObject [
	state := anObject
]
