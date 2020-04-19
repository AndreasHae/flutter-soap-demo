# Flutter SOAP client demo

This project serves as an example for how to handle SOAP requests in Flutter. It uses the `http` package to send requests to the SOAP service and the `xml` package to build and parse requests in XML. The app requires the [corresponding service](URL of service) to process requests in a specific schema.

## Possible improvements

- **Publish SOAP client as library**  
  While usage of SOAP is steadily declining, there are some enterprise services which still depend on the protocol. Implementing a simple way to handle communication via SOAP could increase adoption of Flutter in enterprise IT environments.

- **Generate model classes from XSD**  
  In order to achieve the best possible integration between frontend and backend systems, model classes should be generated from XSD files automatically. This ensures continuity between frontend and backend models and decreases time spent on manually writing boilerplate code for parsing and writing XML for model classes. The generator could, just like the SOAP client, be published as a library that can be used by enterprise applications.


## Motivations

The project originated from a networking assignment which consisted of writing a backend service and Android client application using the SOAP protocol. I chose Flutter for developing the client application because of its ease of use. However, there is currently no exising SOAP client library, so I wrote my own SOAP client using the `http` and `xml` packages. For now, the project just serves as a reference for fellow app developers having to work with SOAP backend services. It is unclear if I will ever get around implementing the improvements listed above. If someone else has the motivation to do so, please let me know! Pull requests are welcome.