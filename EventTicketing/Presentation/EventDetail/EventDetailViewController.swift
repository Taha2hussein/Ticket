//
//  EventDetailViewController.swift
//  EventTicketing
//
//  Created by Macos on 30/11/2025.
//

import UIKit
class EventDetailViewController: UIViewController {
    
    private let event: Event
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray6
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let sharButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.backgroundColor = .white
        btn.tintColor = .black
        btn.layer.cornerRadius = 22
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let dateOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemRed
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let organizerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let getTicketsButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Get tickets", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemRed
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithEvent()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(coverImageView)
        contentView.addSubview(dateOverlay)
        dateOverlay.addSubview(monthLabel)
        dateOverlay.addSubview(dayLabel)
        contentView.addSubview(sharButton)
        contentView.addSubview(contentStack)
        view.addSubview(getTicketsButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: getTicketsButton.topAnchor, constant: -16),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 300),
            
            dateOverlay.topAnchor.constraint(equalTo: coverImageView.topAnchor, constant: 60),
            dateOverlay.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor, constant: 16),
            dateOverlay.widthAnchor.constraint(equalToConstant: 70),
            dateOverlay.heightAnchor.constraint(equalToConstant: 70),
            
            monthLabel.topAnchor.constraint(equalTo: dateOverlay.topAnchor, constant: 8),
            monthLabel.centerXAnchor.constraint(equalTo: dateOverlay.centerXAnchor),
            
            dayLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 2),
            dayLabel.centerXAnchor.constraint(equalTo: dateOverlay.centerXAnchor),
            
            sharButton.topAnchor.constraint(equalTo: coverImageView.topAnchor, constant: 60),
            sharButton.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: -16),
            sharButton.widthAnchor.constraint(equalToConstant: 44),
            sharButton.heightAnchor.constraint(equalToConstant: 44),
            
            contentStack.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 24),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            getTicketsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getTicketsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            getTicketsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            getTicketsButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func configureWithEvent() {
        titleLabel.text = event.title?.uppercased()
        organizerLabel.text = "By \(event.organizer ?? "")"
        
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(organizerLabel)
        
        // Artist info
        if let artist = event.artistName {
            let artistRow = createInfoRow(icon: "music.note", title: artist)
            contentStack.addArrangedSubview(artistRow)
        }
        
        // Date & Time
        if let date = event.date {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            dayLabel.text = dayFormatter.string(from: date)
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMMM"
            monthLabel.text = monthFormatter.string(from: date).uppercased()
            
            let fullDateFormatter = DateFormatter()
            fullDateFormatter.dateFormat = "dd MMMM"
            var dateText = fullDateFormatter.string(from: date)
            
            if let start = event.startTime, let end = event.endTime {
                dateText += "\n\(start) - \(end) GMT+2"
            }
            
            let dateRow = createInfoRow(icon: "calendar", title: dateText)
            contentStack.addArrangedSubview(dateRow)
        }
        
        // Location
        if let location = event.location {
            let locationRow = createInfoRow(icon: "mappin.and.ellipse", title: location)
            contentStack.addArrangedSubview(locationRow)
        }
        
        // Countdown
        if let countdown = event.salesCountdown {
            let countdownRow = createInfoRow(icon: "ticket", title: "Sales end in \(countdown) days\nGet tickets")
            contentStack.addArrangedSubview(countdownRow)
        }
        
        // Age limit
        if let ageLimit = event.ageLimit {
            let ageRow = createInfoRow(icon: "checkmark.circle", title: ageLimit)
            contentStack.addArrangedSubview(ageRow)
        }
        
        // Important info
        if let description = event.eventDescription {
            let infoBox = createImportantInfoBox(text: description)
            contentStack.addArrangedSubview(infoBox)
        }
        
        // Load image
        if let imageURL = event.coverImageURL {
            ImageCacheService.shared.loadImage(from: imageURL) { [weak self] image in
                self?.coverImageView.image = image
            }
        }
    }
    
    private func createInfoRow(icon: String, title: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let iconView = UIImageView()
        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = .secondaryLabel
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(iconView)
        container.addSubview(label)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: 2),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            label.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            label.topAnchor.constraint(equalTo: container.topAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
    
    private func createImportantInfoBox(text: String) -> UIView {
        let container = UIView()
        container.backgroundColor = .systemRed.withAlphaComponent(0.1)
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "📋 Important Information:"
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .systemRed
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descLabel = UILabel()
        descLabel.text = text
        descLabel.font = .systemFont(ofSize: 14)
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(titleLabel)
        container.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            descLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            descLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
        
        return container
    }
}
