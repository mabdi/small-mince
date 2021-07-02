Extension { #name : #Error }

{ #category : #'*SmallMince-Core' }
Error >> sm_valueReference [
	^ SMErrorValue with: self
]
