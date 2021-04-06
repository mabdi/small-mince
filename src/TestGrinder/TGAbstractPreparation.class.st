Class {
	#name : #TGAbstractPreparation,
	#superclass : #Object,
	#instVars : [
		'histories'
	],
	#category : #'TestGrinder-3.Preparation'
}

{ #category : #copying }
TGAbstractPreparation class >> , anotherTGAbstractPreparation [
]

{ #category : #'as yet unclassified' }
TGAbstractPreparation >> doPreparation [
	^ self subclassResponsibility 
]

{ #category : #accessing }
TGAbstractPreparation >> histories [
	^ histories
]

{ #category : #accessing }
TGAbstractPreparation >> histories: anObject [
	histories := anObject
]

{ #category : #testing }
TGAbstractPreparation >> isTGPreparation [
	^ true
]

{ #category : #'as yet unclassified' }
TGAbstractPreparation >> tg_internal_class [
	^ true
]
