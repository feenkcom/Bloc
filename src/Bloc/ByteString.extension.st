Extension { #name : #ByteString }

{ #category : #'*Bloc' }
ByteString >> gtCharIndexAtByteOffset: anOffset [
	^ (anOffset + 1) min: self size
]
