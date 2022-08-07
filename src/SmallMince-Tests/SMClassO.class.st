Class {
	#name : #SMClassO,
	#superclass : #Object,
	#instVars : [
		'last'
	],
	#category : #'SmallMince-Tests'
}

{ #category : #'as yet unclassified' }
SMClassO >> mo1A: aObj X: xObj [

	| y |
	last := #mo1.
	xObj mx1.
	y := SMClassY new.
	xObj mx2Y: y
]

{ #category : #'as yet unclassified' }
SMClassO >> mo2 [

	| r |
	last := #mo2.
	r := SMClassR new.
	r mr1.
	^ r
]

{ #category : #'as yet unclassified' }
SMClassO >> mo3 [

	last := #mo3
]

{ #category : #'as yet unclassified' }
SMClassO >> mo4 [
	" I am a state preserving method"
	^ 1
]

{ #category : #'as yet unclassified' }
SMClassO >> mo5: anArg [

	" I am a state preserving method"

	^ 1
]
