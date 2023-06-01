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
