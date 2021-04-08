Extension { #name : #Fraction }

{ #category : #'*SmalltalkTestGrinder' }
Fraction >> tg_valueReference [
	^ TGFractionValue with: self
]
