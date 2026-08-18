Class {
	#name : #BaselineOfBlocCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocCore
}

{ #category : #baseline }
BaselineOfBlocCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:main/src' ];
			baseline: 'Fenster' with: [
				spec repository: 'github://feenkcom/fenster/src' ].
		spec 
			package: #Bloc with: [
				spec requires: #(#Beacon Fenster) ];
			package: #'BlocHost-Mock' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Tests' with: [
				spec requires: #(#Bloc 'BlocHost-Mock' ). ]. ].
]
