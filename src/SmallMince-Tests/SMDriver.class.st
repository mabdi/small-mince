Class {
	#name : #SMDriver,
	#superclass : #Object,
	#category : #'SmallMince-Tests'
}

{ #category : #'as yet unclassified' }
SMDriver >> md1: aSymbol [

	"..."

	| retVal a x |
	aSymbol = #ClassO ifTrue: [ "..."
		retVal := SMClassO new.
		a := SMClassA new.
		x := SMClassX new.
		retVal mo1A: a X: x.
		^ retVal ]
]

{ #category : #'as yet unclassified' }
SMDriver >> md2 [
]

{ #category : #'as yet unclassified' }
SMDriver >> md3: objO [

	
]
