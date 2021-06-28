Extension { #name : #Object }

{ #category : #'*SmallMince-Core' }
Object >> sm_internal_class [
	^ false
]

{ #category : #'*SmallMince-Core' }
Object >> sm_valueReference [
	^ SMSkippedValue with: self
]
