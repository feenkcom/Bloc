Class {
	#name : #BaselineOfBlocExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocExamples
}

{ #category : #baseline }
BaselineOfBlocExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.829/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:df86603dd9fbb2f85a657a5d52bbb47731f75cc4/repository' ].
		spec
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.199/src' ].
		spec
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.102/src' ].

		spec package: 'Bloc-Text-Examples' with: [
			spec requires: #(#Bloc) ].
		spec package: 'Bloc-Layout-Examples' with: [
			spec requires: #(#Bloc #GToolkitExamplesEngine) ].
		spec package: 'Bloc-Examples' with: [
			spec requires: #(#Bloc) ].
		spec package: 'Bloc-Compositor-Examples' with: [
			spec requires: #(#Bloc #'Bloc-Examples') ].
		spec package: 'Bloc-Docs' with: [
			spec requires: #(#Bloc) ].
	]
]
