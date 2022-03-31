Class {
	#name : #BlGlutinHost,
	#superclass : #BlWinitHost,
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #testing }
BlGlutinHost class >> isSupported [
	^ Glutin isSupported and: [ RustWindowingEventFetcher default eventLoop isGlutin ] 
]

{ #category : #accessing }
BlGlutinHost class >> priority [
	^ 2
]
