Extension { #name : #Boolean }

{ #category : #'*SmallMince-Core' }
Boolean >> sm_valueReference [
	^ SMPrimitiveValue  with: self
]
