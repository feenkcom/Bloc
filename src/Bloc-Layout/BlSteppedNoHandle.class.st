Class {
	#name : #BlSteppedNoHandle,
	#superclass : #BlSteppedHandle,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #measure }
BlSteppedNoHandle >> state: aState measure: aCollectionOfLayoutChildNode [
	aCollectionOfLayoutChildNode do: [ :eachChild | 
		aState measureAndPlaceChild: eachChild ]
]
