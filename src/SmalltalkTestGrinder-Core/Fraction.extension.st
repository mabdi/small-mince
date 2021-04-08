Extension { #name : #Fraction }

{ #category : #'*SmalltalkTestGrinder-Core' }
Fraction >> tg_valueReference [
	^ TGFractionValue with: self
]
