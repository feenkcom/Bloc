Class {
	#name : #BlFileCollectionRopeExamples,
	#superclass : #BlCollectionRopeExamples,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #accessing }
BlFileCollectionRopeExamples >> bufferedIndexes [
	"Test that buffering + index calculations work"
	<gtExample>
	| rope result file |
	file := FileSystem memory / 'test.txt'.
	file writeStreamDo: [ :stream | stream << 'foobarbaz' ].
	rope := BlRopeableCollectionFile new
			bufferSize: 3;
			fileReference: file.	
			
	"The following test uses an explicit whileTrue: loop instead of to:do: since `rope size` can be different every time"
	result := String
			streamContents: [ :str | 
				| i |
				i := 1.
				[ i <= rope size ]
					whileTrue: [ str nextPut: (rope at: i).
						i := i + 1 ] ].
	self assert: result = 'foobarbaz'.
	^ result
]

{ #category : #'instance creation' }
BlFileCollectionRopeExamples >> large [
	<gtExample>
	| aRope file aString aRopeFile |
	aString := String new: 1024 * 1024 withAll: $X.
	file := FileSystem memory / 'test.txt'.
	file writeStreamDo: [ :stream | stream nextPutAll: aString ].
	aRopeFile := BlRopeableCollectionFile new fileReference: file.
	aRope := BlCollectionRope collection: aRopeFile.

	self assert: aRope depth equals: 1.
	self assert: aRope size equals: aString size.
	self assert: aRope collection equals: aString.
	self assert: aRopeFile approximateSize equals: aString size.

	aRopeFile ensureBuffered: aString size.
	self assert: aRope depth equals: 1.
	self assert: aRope size equals: aString size.
	self assert: aRope collection equals: aString.
	self assert: aRopeFile approximateSize equals: aString size.

	^ aRope
]

{ #category : #'instance creation' }
BlFileCollectionRopeExamples >> small [
	<gtExample>
	<label: 'Creates an instance of the rope of size smaller than combineLength'>
	| aRope file |

	file := FileSystem memory / 'test.txt'.
	file writeStreamDo: [ :stream | stream << 'Hello' ].
	aRope := BlCollectionRope collection: 
					(BlRopeableCollectionFile new fileReference: file).

	self assert: aRope depth equals: 1.
	self assert: aRope size equals: 5.
	self assert: aRope collection equals: 'Hello'.
	self assert: aRope isLeaf.
	self assert: aRope size <= BlRope combineLength.

	^ aRope
]
