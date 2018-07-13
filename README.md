# Problem Statement

https://gist.github.com/mntdamania/9a3bf1760f239fb28b867b98494b84d9

# Shop Cart
<b>Requirements</b><br/>
ruby 2.3
<br/>
<br/>
<b>Run Application</b>
<ul>
  <li><code>bundle install</code> (Gems used: faraday, rake, rspec)</li>
  <li>Run <b><code>ruby lib/shop_cart.rb &lt coupon_code &gt &lt outlet_it &gt</code></b></li>
  <small> **Go to the root of project folder and run this command, it will auto download the coupon_codes.json file using a rake task [json:coupon_codes], this task can be run again from the app root folder to re-download the file</small>
  <small> **json/cart_items.json is the application input file, modify accordingly</small>
  <li>Run <b><code>rspec . </code></b> from the App root folder to run test cases</li>
</ul>
<br/>
<br/>
<b>Assumptions:</b>
<ul>
  <li>Maximum discount is applied if the discount value is greater than max_discount.</li>
  <li>Cashback value not considered while validating minimum_delivery_amount_after_discount and maximum_discount.</li>
  <li>If BOGO discount becomess greater than the max_discount, then max_discount is applied.</li>
</ul>
<br/>
<br/>
<b>Application Structure</b>
<ul>
  <li>
    <b>config</b> - Contains all the configuration, constants, errors classes
    <ul>
      <li><i>constants.rb</i> - Constant Strings used throughout the application.</li>
      <li><i>errors.rb</i> - Errors String used while raising an exceeption.</li>
    </ul>
  </li>
  <li>
    <b>json</b> - Contains all the static jsons used by the application
    <ul>
      <li><i>cart_items.json</i> - Input cart json over which the discount is computed.</li>
      <li><i>coupon_codes.json</i> - Available Discount coupons and their types for running the application. This file can be downloaded by directly running the application (ruby lib/shop_cart.rb) or explicitly by running the rake command (rake json:coupon_codes)</li>
    </ul>
  </li>
  <li>
    <b>tasks</b> - Contains all the rake task files required by the application.
    <ul>
      <li><i>download.rake</i> - All tasks to perform external file download for application.</li>
    </ul>
  </li>
  <li>
    <b>specs</b> - Contains all unit test cases
  </li>
  <li>
    <b>lib</b> - Contains all the application init and core source files
    <ul>
      <li><i>shop_cart.rb</i> - Application init file which loads all the core source files and initiates the application process.</li>
      <li>
        <b>shop_cart</b> - Contains all the core source files
        <ul>
          <li><i>discount.rb</i> - Responsible for applying discount by creating the Cart and CouponType instances and returning the final result. Complete relation among files is explained in the following figure.</li>
        </ul>
      </li>
    </ul>
  </li>
</ul>
<img src="assets/shop_cart_application_structure.jpg">
