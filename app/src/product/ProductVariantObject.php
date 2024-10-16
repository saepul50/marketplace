<?php 
use SilverStripe\Forms\NumericField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Forms\RequiredFields;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;

class ProductVariantObject extends DataObject {
    private static $db = [
        'VariantName' => 'Text',
        'Price' => 'Decimal(19, 2)',
        'Stock' => 'Int',
        'Weight' => 'Decimal',
    ];

    private static $has_one = [
        'Product' => ProductObject::class
    ];

    private static $summary_fields = [
        'VariantName' => 'Variant',
        'Price' => 'Price',
        'Stock' => 'Stock',
        'Weight' => 'Weight',
    ];

    public function onBeforeWrite() {
        parent::onBeforeWrite();
        if ($this->Price) {
            $this->Price = number_format($this->Price, 2, '.', '');
        }
    }

    public function onAfterWrite() {
        parent::onAfterWrite();
        if ($this->VariantImageID && $this->VariantImage()->exists()) {
            $this->VariantImage()->publishSingle();
        }
    }

    public function getNormalPrice() {
        return 'Rp. ' . number_format($this->Price, 0, '', '.');
    }

    public function getDiscountedPrice() {
        $promotion = $this->Product->Promotion()->first();
        if ($promotion && $promotion->PromoPrice) {
            $originalPrice = $this->Price;
            $promoPrice = $promotion->PromoPrice;
            $discountedPrice = $originalPrice * (1 - $promoPrice / 100);
            return 'Rp. ' . number_format($discountedPrice, 0, '', '.');
        }
        return 'Rp. ' . number_format($this->Price, 0, '', '.');
    }

    private function getInlineJavaScript() {
        return "
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    const numericInputs = document.querySelectorAll('.numeric-input');
                    numericInputs.forEach(input => {
                        input.addEventListener('input', function(event) {
                            this.value = this.value.replace(/[^0-9]/g, ''); // Mengganti semua karakter yang bukan angka
                        });
                    });
                });
            </script>
        ";
    }    
    public function getCMSFields() {
        $fields = new FieldList(
            LiteralField::create('InlineJS', $this->getInlineJavaScript()),
            TextField::create('VariantName', 'Variant'),
            NumericField::create('Price')->setDescription('Input Only Number')->addExtraClass('numeric-input'),
            NumericField::create('Stock', 'Stock')->addExtraClass('numeric-input'),
            NumericField::create('Weight')->setDescription('/grams')->addExtraClass('numeric-input')
        );

        return $fields;
    }


    public function canCreate($member = null, $context = []) {
        return true; 
    }

    public function canView($member = null) {
        return true;
    }

    public function canEdit($member = null) {
        return true;
    }

    public function canDelete($member = null) {
        return true;
    }

    function getCMSValidator() {
        return new VariantObject_validator();
    }
}

class VariantObject_validator extends RequiredFields {
    function php($data) {
        $bRet = parent::php($data);

        if (empty($data['VariantName'])) {
            $this->validationError('VariantName', 'Variant cannot be empty', 'required');
        }
        if (empty($data['Price'])) {
            $this->validationError('Price', 'Price must be correct', 'required');
        }
        if (empty($data['Stock'])) {
            $this->validationError('Stock', 'Stock must be correct', 'required');
        }
        if (empty($data['Weight'])) {
            $this->validationError('Weight', 'Weight must be correct', 'required');
        }
        return count($this->getErrors());
    }
}
