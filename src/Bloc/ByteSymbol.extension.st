Extension { #name : #ByteSymbol }

{ #category : #'*Bloc' }
ByteSymbol >> gtCharIndexAtByteOffset: anOffset [
	^ (anOffset + 1) min: self size
]
