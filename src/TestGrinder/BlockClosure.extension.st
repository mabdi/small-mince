Extension { #name : #BlockClosure }

{ #category : #'*TestGrinder' }
BlockClosure >> tg_state [
	^ TGBlockValue  with: self
]
