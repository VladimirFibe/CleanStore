//
//  CreateOrderPresenter.swift
//  CleanStore
//
//  Created by Vladimir Fibe on 06.09.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CreateOrderPresentationLogic
{
  func presentSomething(response: CreateOrder.Something.Response)
}

class CreateOrderPresenter: CreateOrderPresentationLogic
{
  weak var viewController: CreateOrderDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: CreateOrder.Something.Response)
  {
    let viewModel = CreateOrder.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
