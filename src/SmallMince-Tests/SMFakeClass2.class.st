Class {
	#name : #SMFakeClass2,
	#superclass : #Object,
	#category : #'SmallMince-Tests-Helpers'
}

{ #category : #adding }
SMFakeClass2 >> addHundred: aFake1 [
	^ aFake1 sum: 100 ; yourself
]

{ #category : #'as yet unclassified' }
SMFakeClass2 >> getFake1 [
	^ SMFakeClass1 new
]

{ #category : #running }
SMFakeClass2 >> run [
	|v1 v2 |
	v1 := self getFake1 sum: 50.
	v2 := self getFake1 sum: 60.
	^ v1 balance + v2 balance 
]
