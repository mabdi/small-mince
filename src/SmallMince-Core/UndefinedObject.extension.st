Extension { #name : #UndefinedObject }

{ #category : #'*SmallMince-Core' }
UndefinedObject >> sm_valueReference [
	^ SMNullValue with: self
]
