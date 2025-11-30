//
//  EventCell.swift
//  EventTicketing
//
//  Created by Macos on 30/11/2025.
//


import UIKit

//
//  EventCell.swift
//  EventTicketing
//
//  Created by Macos on 30/11/2025.
//

import UIKit

class EventCell: UITableViewCell {
    
    private let mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(red: 0.95, green: 0.77, blue: 0.25, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let salesDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let quantityContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let minusButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("−", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 28, weight: .medium)
        btn.backgroundColor = UIColor(red: 0.95, green: 0.77, blue: 0.25, alpha: 1.0)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        btn.backgroundColor = UIColor(red: 0.95, green: 0.77, blue: 0.25, alpha: 1.0)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemGray6
        selectionStyle = .none
        
        contentView.addSubview(mainContainer)
        mainContainer.addSubview(titleLabel)
        mainContainer.addSubview(priceLabel)
        mainContainer.addSubview(salesDateLabel)
        mainContainer.addSubview(descriptionStack)
        mainContainer.addSubview(quantityContainer)
        
        quantityContainer.addSubview(minusButton)
        quantityContainer.addSubview(quantityLabel)
        quantityContainer.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            // Main Container
            mainContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: quantityContainer.leadingAnchor, constant: -16),
            
            // Price
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 16),
            
            // Sales Date
            salesDateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            salesDateLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 16),
            
            // Description Stack
            descriptionStack.topAnchor.constraint(equalTo: salesDateLabel.bottomAnchor, constant: 12),
            descriptionStack.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 16),
            descriptionStack.trailingAnchor.constraint(equalTo: quantityContainer.leadingAnchor, constant: -16),
            descriptionStack.bottomAnchor.constraint(lessThanOrEqualTo: mainContainer.bottomAnchor, constant: -16),
            
            // Quantity Container
            quantityContainer.centerYAnchor.constraint(equalTo: mainContainer.centerYAnchor),
            quantityContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -16),
            quantityContainer.widthAnchor.constraint(equalToConstant: 140),
            quantityContainer.heightAnchor.constraint(equalToConstant: 40),
            
            minusButton.leadingAnchor.constraint(equalTo: quantityContainer.leadingAnchor),
            minusButton.centerYAnchor.constraint(equalTo: quantityContainer.centerYAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 40),
            minusButton.heightAnchor.constraint(equalToConstant: 40),
            
            quantityLabel.centerXAnchor.constraint(equalTo: quantityContainer.centerXAnchor),
            quantityLabel.centerYAnchor.constraint(equalTo: quantityContainer.centerYAnchor),
            
            plusButton.trailingAnchor.constraint(equalTo: quantityContainer.trailingAnchor),
            plusButton.centerYAnchor.constraint(equalTo: quantityContainer.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 40),
            plusButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(with event: Event) {
        // Title
        titleLabel.text = event.title?.uppercased()
        
        // Price
        if let price = event.price {
            priceLabel.text = price
        } else {
            priceLabel.text = "SOLD OUT"
            priceLabel.textColor = .systemRed
        }
        
        // Sales Date
        if let date = event.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"
            salesDateLabel.text = "Sales end on \(formatter.string(from: date))"
        }
        
        // Clear previous descriptions
        descriptionStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add descriptions
        let descriptions = [
            event.des1,
            event.des2,
            event.des3
        ].compactMap { $0 }
        
        for desc in descriptions {
            let label = UILabel()
            label.text = "■  \(desc)"
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textColor = .secondaryLabel
            label.numberOfLines = 0
            descriptionStack.addArrangedSubview(label)
            
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        priceLabel.text = nil
        priceLabel.textColor = UIColor(red: 0.95, green: 0.77, blue: 0.25, alpha: 1.0)
        salesDateLabel.text = nil
        quantityLabel.text = "0"
        descriptionStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
