Class {
	#name : #BlSteppedLayoutNoHandle,
	#superclass : #BlSteppedLayoutHandle,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #measure }
BlSteppedLayoutNoHandle >> state: aState measure: aCollectionOfLayoutChildNode [
	aCollectionOfLayoutChildNode do: [ :eachChild | 
		aState measureAndPlaceChild: eachChild ]
]
