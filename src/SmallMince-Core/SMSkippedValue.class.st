Class {
	#name : #SMSkippedValue,
	#superclass : #SMAbstractValue,
	#category : #'SmallMince-Core-Model'
}

{ #category : #'as yet unclassified' }
SMSkippedValue >> synthesisBy: aSynthesizer [
	^ aSynthesizer synthesisSkippedValue: self
]
