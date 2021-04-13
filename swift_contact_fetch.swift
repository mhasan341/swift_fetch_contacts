    
    func fetchContacts() {
        
        let store = CNContactStore()
        // request permission
        store.requestAccess(for: .contacts) { [self] (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                // we will be requesting for the following data from each contact
                // more keys can be found here => https://developer.apple.com/documentation/contacts/contact_keys
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey, CNContactImageDataAvailableKey]
                // create the request
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                // different sort order available => https://developer.apple.com/documentation/contacts/cncontactsortorder?language=swift
                request.sortOrder = CNContactSortOrder.givenName
                do {
                    
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        // if this contact has no phone number, we won't count him
                        // for one of my past project, any valid US number has a length of 10 or more                                          
                        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue, phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined().count >= 10{
                        // see my swift_phone_number_format repo for this function
                            let number = formatNumber(phoneNumber)
                            // fill the all contact Array to reuse later
                            
                            // YOU HAVE THE FORMATTED NUMBER HERE
                            // DO WHAT YOU WANT
                            
                        }
                        
                        
                    })
                   
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
                                             
        }// end of req access
    } // end of fetch
