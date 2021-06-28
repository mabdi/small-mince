Extension { #name : #Fraction }

{ #category : #'*SmallMince-Core' }
Fraction >> sm_valueReference [
	^ SMFractionValue with: self
]
