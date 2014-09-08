

class StatusController < ApplicationController
  gem 'rest_client'
  require 'rest-client'
  require 'json'
  require 'base64'

  username='admin'
  password='password'
  Authheader='X-Concerto-Authorization'
  Enc = Base64.encode64(username+":"+password)
  API_base_url = 'https://ave71.lab.local:8543'
  Loginurl='https://ave71.lab.local:8543/rest-api/login'
  Versionurl='https://ave71.lab.local:8543/rest-api/versions'
  Resourcelisturl='https://ave71.lab.local:8543/rest-api/DataProtectionResourceDetailList'

 def index
   data = RestClient.post Loginurl,nil, { 'Content-type'=>'Application/json','Accept'=>'Application/json','Authorization' => "Basic "+Enc }
   @JsonData = data
   @data = JSON.parse(data, :symbolize_names =>true)
   @authvalue=data.headers[:'x_concerto_authorization']
   #print "\nX-Concerto-Authorization : "+@authvalue+"\n"
   #print "====== Making Get call to fetch Version information =======\n"

  @Providerhref = @data[:'accessPoint']
  @Providerhref = @Providerhref[0]
  @Providerhref = @Providerhref[:'href']


   #rest_resource = RestClient::Resource.new(Versionurl)
   @versionJson = RestClient.get Versionurl,{ 'Content-type'=>'Application/json','Accept'=>'Application/json',Authheader => @authvalue}

   @ProviderKeys = RestClient.get @Providerhref,{ 'Content-type'=>'Application/json','Accept'=>'Application/json',Authheader => @authvalue}
   @version = JSON.parse(@versionJson, :symbolize_names =>true)

   @ProviderKeys = JSON.parse(@ProviderKeys,:symbolize_names =>true )

   @Tenants = @ProviderKeys[:'Tenant']


   param = :'entryPoint'
   @entrypoint = @version[param]

   @entrypoint = @entrypoint[0]
   #@test2 = @version[:'entryPoint']
  # @test3 = @test2[:'apiVersion']
 end

  def new

  end

  def create

  end

  def show


  end
end
