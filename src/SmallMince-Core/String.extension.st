Extension { #name : #String }

{ #category : #'*SmallMince-Core' }
String >> sm_valueReference [
	^ SMPrimitiveValue  with: self
]
