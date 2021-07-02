Class {
	#name : #SMAbstractMethodSynthesizer,
	#superclass : #Object,
	#traits : 'SMInternalClassesTrait',
	#classTraits : 'SMInternalClassesTrait classTrait',
	#category : #'SmallMince-Core-4.Synthesis'
}

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisBlockValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisClassPrimitiveValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisDictionaryValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisListValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisNullValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisObjectErrorEvent: anObjectEvent [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisObjectHistory: anObjectHistory [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisObjectReference: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisObjectReturnEvent: anObjectEvent [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisPrimitiveValue: anObject [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SMAbstractMethodSynthesizer >> synthesisSkippedValue: anObject [
	^ self subclassResponsibility 
]
