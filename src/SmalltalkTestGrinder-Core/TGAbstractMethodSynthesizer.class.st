Class {
	#name : #TGAbstractMethodSynthesizer,
	#superclass : #Object,
	#traits : 'TGInternalClassesTrait',
	#classTraits : 'TGInternalClassesTrait classTrait',
	#category : #'SmalltalkTestGrinder-Core-4.Synthesis'
}

{ #category : #'as yet unclassified' }
TGAbstractMethodSynthesizer >> synthesisBlockValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TGAbstractMethodSynthesizer >> synthesisClassPrimitiveValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TGAbstractMethodSynthesizer >> synthesisDictionaryValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TGAbstractMethodSynthesizer >> synthesisListValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TGAbstractMethodSynthesizer >> synthesisNullValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TGAbstractMethodSynthesizer >> synthesisObjectEvent: anObjectEvent [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TGAbstractMethodSynthesizer >> synthesisObjectHistory: anObjectHistory [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TGAbstractMethodSynthesizer >> synthesisObjectReference: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TGAbstractMethodSynthesizer >> synthesisPrimitiveValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TGAbstractMethodSynthesizer >> synthesisSkippedValue: anObject [
	^ self subclassResponsibility 
]
