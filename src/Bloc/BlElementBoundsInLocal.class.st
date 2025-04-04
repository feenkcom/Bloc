Class {
	#name : #BlElementBoundsInLocal,
	#superclass : #BlElementComputedBounds,
	#category : #'Bloc-Core-Bounds'
}

{ #category : #'geometry bounds' }
BlElementBoundsInLocal >> inParent [
	<return: #BlElementBounds>

	^ BlElementBoundsInParent new
		originalElement: self referenceElement;
		referenceElement: self referenceElement;
		bounds: (self localBoundsToParent: self bounds copy);
		yourself
]

{ #category : #'geometry bounds' }
BlElementBoundsInLocal >> inSpace [
	<return: #BlElementBounds>

	^ BlElementBoundsInSpace new
		referenceElement: self referenceElement;
		bounds: (self localBoundsToSpace: self bounds copy);
		yourself
]
