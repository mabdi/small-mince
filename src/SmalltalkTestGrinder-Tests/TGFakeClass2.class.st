Class {
	#name : #TGFakeClass2,
	#superclass : #Object,
	#category : #'SmalltalkTestGrinder-Tests-Helpers'
}

{ #category : #adding }
TGFakeClass2 >> addHundred: aFake1 [
	^ aFake1 sum: 100 ; yourself
]

{ #category : #'as yet unclassified' }
TGFakeClass2 >> getFake1 [
	^ TGFakeClass1 new
]

{ #category : #running }
TGFakeClass2 >> run [
	|v1 v2 |
	v1 := self getFake1 sum: 50.
	v2 := self getFake1 sum: 60.
	^ v1 balance + v2 balance 
]
