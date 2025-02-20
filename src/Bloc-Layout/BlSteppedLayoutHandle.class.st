"
I define whether a first {{gtClass:BlElement}} child is considered a (context menu) handle or regular (context) menu element.

"
Class {
	#name : #BlSteppedLayoutHandle,
	#superclass : #Object,
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #'instance creation' }
BlSteppedLayoutHandle class >> center [
	^ BlSteppedLayoutCenterHandle new
]

{ #category : #'instance creation' }
BlSteppedLayoutHandle class >> null [
	^ BlSteppedLayoutNoHandle new
]

{ #category : #'instance creation' }
BlSteppedLayoutHandle class >> topLeft [
	^ BlSteppedLayoutTopLeftHandle new
]

{ #category : #measure }
BlSteppedLayoutHandle >> state: aState measure: aCollectionOfLayoutChildNode [
	self subclassResponsibility
]
