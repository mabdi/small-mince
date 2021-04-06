Extension { #name : #Fraction }

{ #category : #'*TestGrinder' }
Fraction >> tg_valueReference [
	^ TGFractionValue with: self
]
